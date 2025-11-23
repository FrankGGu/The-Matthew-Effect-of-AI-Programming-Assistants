#include <vector>
#include <string>
#include <numeric>
#include <algorithm>
#include <unordered_map>
#include <set> // For sorting and uniqueness, though vector + sort + unique is also an option

class DSU {
public:
    std::vector<int> parent;
    DSU(int n) {
        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0); // Initialize parent[i] = i
    }

    int find(int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent[i]); // Path compression
    }

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            parent[root_i] = root_j; // Union by rank/size could be added, but simple union is often sufficient
        }
    }
};

class Solution {
public:
    std::vector<std::vector<std::string>> accountsMerge(std::vector<std::vector<std::string>>& accounts) {
        std::unordered_map<std::string, int> email_to_id;
        std::vector<std::string> id_to_email; // Maps integer ID back to email string
        std::unordered_map<std::string, std::string> email_to_name; // Maps an email to the owner's name

        int id_counter = 0;

        // First pass: Assign unique IDs to all emails and store owner names
        for (const auto& account : accounts) {
            std::string name = account[0];
            for (size_t i = 1; i < account.size(); ++i) {
                const std::string& email = account[i];
                if (email_to_id.find(email) == email_to_id.end()) {
                    email_to_id[email] = id_counter;
                    id_to_email.push_back(email);
                    id_counter++;
                }
                email_to_name[email] = name; // Store the name associated with this email
            }
        }

        DSU dsu(id_counter);

        // Second pass: Perform unions based on shared emails within accounts
        for (const auto& account : accounts) {
            if (account.size() <= 1) continue; // Account has only a name, no emails
            int first_email_id = email_to_id[account[1]];
            for (size_t i = 2; i < account.size(); ++i) {
                int current_email_id = email_to_id[account[i]];
                dsu.unite(first_email_id, current_email_id);
            }
        }

        // Third pass: Group emails by their root parent ID
        std::unordered_map<int, std::vector<std::string>> merged_groups; // root_id -> list of emails
        for (int i = 0; i < id_counter; ++i) {
            int root_id = dsu.find(i);
            merged_groups[root_id].push_back(id_to_email[i]);
        }

        // Final step: Construct the result
        std::vector<std::vector<std::string>> result;
        for (auto const& [root_id, emails] : merged_groups) {
            std::vector<std::string> current_account;

            // Get the name associated with this merged account.
            // We can use any email from the group to find the name,
            // but using the email corresponding to the root_id is convenient.
            std::string representative_email_str = id_to_email[root_id];
            current_account.push_back(email_to_name[representative_email_str]);

            // Sort the emails and add them to the account
            std::vector<std::string> sorted_emails = emails;
            std::sort(sorted_emails.begin(), sorted_emails.end());
            current_account.insert(current_account.end(), sorted_emails.begin(), sorted_emails.end());

            result.push_back(current_account);
        }

        return result;
    }
};