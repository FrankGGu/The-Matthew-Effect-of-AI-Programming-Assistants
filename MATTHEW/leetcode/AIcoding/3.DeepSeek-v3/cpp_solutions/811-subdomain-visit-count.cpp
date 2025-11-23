class Solution {
public:
    vector<string> subdomainVisits(vector<string>& cpdomains) {
        unordered_map<string, int> count;
        for (const string& cpdomain : cpdomains) {
            int space_pos = cpdomain.find(' ');
            int num = stoi(cpdomain.substr(0, space_pos));
            string domain = cpdomain.substr(space_pos + 1);
            count[domain] += num;
            for (int i = 0; i < domain.size(); ++i) {
                if (domain[i] == '.') {
                    string subdomain = domain.substr(i + 1);
                    count[subdomain] += num;
                }
            }
        }
        vector<string> result;
        for (const auto& entry : count) {
            result.push_back(to_string(entry.second) + " " + entry.first);
        }
        return result;
    }
};