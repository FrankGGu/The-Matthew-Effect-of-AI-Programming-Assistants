#include <string>
#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    bool equalFrequency(string word) {
        vector<int> freq(26, 0);
        for (char c : word) {
            freq[c - 'a']++;
        }

        for (int i = 0; i < word.size(); i++) {
            vector<int> temp_freq = freq;
            temp_freq[word[i] - 'a']--;

            vector<int> non_zero_freq;
            for(int j = 0; j < 26; j++){
                if(temp_freq[j] > 0){
                    non_zero_freq.push_back(temp_freq[j]);
                }
            }

            if(non_zero_freq.empty()) return true;

            bool equal = true;
            for(int j = 1; j < non_zero_freq.size(); j++){
                if(non_zero_freq[j] != non_zero_freq[0]){
                    equal = false;
                    break;
                }
            }

            if(equal) return true;
        }

        return false;
    }
};