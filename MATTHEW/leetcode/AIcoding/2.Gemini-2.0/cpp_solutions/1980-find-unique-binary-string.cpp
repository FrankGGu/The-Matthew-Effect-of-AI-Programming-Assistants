#include <string>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    string findDifferentBinaryString(vector<string>& nums) {
        unordered_set<string> s(nums.begin(), nums.end());
        int n = nums.size();

        function<string(int)> generate = [&](int len) {
            if (len == n) {
                return "";
            }

            string zero = generate(len + 1);
            if (zero != "") {
                string candidate = "0" + zero;
                if (s.find(candidate) == s.end()) {
                    return candidate;
                }
            }

            string one = generate(len + 1);
            if (one != "") {
                string candidate = "1" + one;
                if (s.find(candidate) == s.end()) {
                    return candidate;
                }
            }

            return "";
        };

        string result = generate(0);
        if (result == "") {
            string temp = "";
            for(int i = 0; i < n; ++i){
                temp += '0';
            }

            function<void(int)> solve = [&](int k) {
                if(k == n){
                    if(s.find(temp) == s.end()) return;
                    else {
                        temp = "";
                        return;
                    }
                }

                if(temp != ""){
                   temp[k] = '0';
                   solve(k+1);
                   if(temp != "") return;

                   temp[k] = '1';
                   solve(k+1);
                   if(temp != "") return;

                }
            };

            temp = "";
            for(int i = 0; i < n; ++i){
                temp += '0';
            }

            for(int i = 0; i < n; ++i){
                temp[i] = '0';
                string temp2 = temp;
                solve(0);
                if(temp2 != "") return temp2;
                temp[i] = '1';
                temp2 = temp;
                solve(0);
                 if(temp2 != "") return temp2;

            }
        }

        if(result == ""){
            string res = "";
            for(int i = 0; i < n; ++i){
                res += '0';
            }
           for(long long i = 0; i < pow(2,n); ++i){
                string binary = "";
               long long temp_i = i;
                for(int j = 0; j < n; ++j){
                    binary = (temp_i % 2 == 0 ? "0" : "1") + binary;
                    temp_i /= 2;
                }
                if(s.find(binary) == s.end()) return binary;
            }

        }

        return result;
    }
};