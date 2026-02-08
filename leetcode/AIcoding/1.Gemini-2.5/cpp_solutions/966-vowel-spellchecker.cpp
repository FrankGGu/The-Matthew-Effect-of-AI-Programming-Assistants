#include <vector>
#include <string>
#include <unordered_set>
#include <unordered_map>
#include <cctype> // For std::tolower

class Solution {
private:
    // Helper function to check if a character is a vowel (case-insensitive)
    static bool isVowel(char c) {
        c = std::tolower(static_cast<unsigned char>(c));
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }

    // Helper function to convert a string to lowercase
    static std::string toLower(std::string s) {
        for (char &c : s) {
            c = std::tolower(static_cast<unsigned char>(c));
        }
        return s;
    }

    // Helper function to convert a string to its vowel-error pattern
    // (lowercase, with all vowels replaced by '#')
    static std::string toVowelPattern(std::string s) {
        s = toLower(s); // First convert to lowercase
        for (char &c : s) {
            if (isVowel(c)) {
                c = '#'; // Replace vowels with a placeholder
            }
        }
        return s;
    }

public:
    std::vector<std::string> spellchecker(std::vector<std::string>& wordlist, std::vector<std::string>& queries) {
        // Data structures to store words for different matching rules
        std::unordered_set<std::string> wordSet; // For exact matches (Rule 1)
        std::unordered_map<std::string, std::string> lowerCaseMap; // For case-insensitive matches (Rule 2)
        std::unordered_map<std::string, std::string> vowelPatternMap; // For vowel-error matches (Rule 3)

        // Populate the data structures from the wordlist
        for (const std::string& w : wordlist) {
            wordSet.insert(w); // Add original word for exact match

            std::string lower_w = toLower(w);
            // Store the original word associated with its lowercase version
            // Only insert if not already present to ensure earliest match is kept
            if (lowerCaseMap.find(lower_w) == lowerCaseMap.end()) {
                lowerCaseMap[lower_w] = w;
            }

            std::string vowel_pattern_w = toVowelPattern(w);
            // Store the original word associated with its vowel-pattern version
            // Only insert if not already present to ensure earliest match is kept
            if (vowelPatternMap.find(vowel_pattern_w) == vowelPatternMap.end()) {
                vowelPatternMap[vowel_pattern_w] = w;
            }
        }

        std::vector<std::string> results;
        results.reserve(queries.size()); // Pre-allocate memory for efficiency

        // Process each query
        for (const std::string& q : queries) {
            // Rule 1: Exact match (case-sensitive)
            if (wordSet.count(q)) {
                results.push_back(q);
                continue;
            }

            // Rule 2: Case-insensitive match
            std::string lower_q = toLower(q);
            if (lowerCaseMap.count(lower_q)) {
                results.push_back(lowerCaseMap[lower_q]);
                continue;
            }

            // Rule 3: Vowel-error match
            std::string vowel_pattern_q = toVowelPattern(q);
            if (vowelPatternMap.count(vowel_pattern_q)) {
                results.push_back(vowelPatternMap[vowel_pattern_q]);
                continue;
            }

            // No match found, return an empty string
            results.push_back("");
        }

        return results;
    }
};