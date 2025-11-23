#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int shortestSequence(vector<int>& rolls, int k) {
        int count = 1;
        unordered_set<string> seen;

        function<void(string, int)> generate = [&](string current, int index) {
            if (index == rolls.size()) {
                if (current.empty()) return;
                if (seen.find(current) == seen.end()) {
                    seen.insert(current);
                }
                return;
            }

            generate(current, index + 1);
            generate(current + to_string(rolls[index]), index + 1);
        };

        while (true) {
            seen.clear();

            function<void(string, int, int)> generate_len = [&](string current, int index, int length) {
                if (current.length() == length) {
                    if (seen.find(current) == seen.end()) {
                        seen.insert(current);
                    }
                    return;
                }

                for (int i = 1; i <= k; ++i) {
                    generate_len(current + to_string(i), index, length);
                }
            };

            unordered_set<string> possible_sequences;
            function<void(string, int)> generate_rolls = [&](string current, int index) {
                if (index == rolls.size()) {
                  possible_sequences.insert(current);
                  return;
                }
                generate_rolls(current + to_string(rolls[index]), index+1);
                generate_rolls(current, index+1);
            };

            int len = count;
            seen.clear();

            function<void(string, int)> gen_seq = [&](string curr, int idx){
                if(curr.length() == len){
                    seen.insert(curr);
                    return;
                }
                for(int i=1; i<=k; ++i){
                    gen_seq(curr + to_string(i), idx+1);
                }
            };

            gen_seq("", 0);

            bool found = false;
            for(const string& seq : seen){
                bool possible = false;

                function<void(string, int)> gen_rolls_check = [&](string current, int index) {
                    if (index == rolls.size()) {
                      if(current == seq){
                          possible = true;
                      }
                      return;
                    }
                    if(possible) return;

                    gen_rolls_check(current + to_string(rolls[index]), index+1);
                    gen_rolls_check(current, index+1);
                };

                gen_rolls_check("", 0);
                if(!possible){
                    return count;
                }

            }

            count++;
        }

        return -1;
    }
};