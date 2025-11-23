#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<string> getDisplayNames(vector<int>& prices, vector<string>& names, int n, int discount) {
        vector<string> result;
        unordered_map<string, int> nameCount;

        for (int i = 0; i < names.size(); ++i) {
            string name = names[i];
            int count = nameCount[name]++;
            if ((count + 1) % n == 0) {
                int discountedPrice = prices[i] * (100 - discount) / 100;
                result.push_back(name + " $" + to_string(discountedPrice));
            } else {
                result.push_back(name + " $" + to_string(prices[i]));
            }
        }

        return result;
    }
};