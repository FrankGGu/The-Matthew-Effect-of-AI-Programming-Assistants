#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> replaceNonCoprimes(vector<int>& nums) {
        vector<int> st;
        for (int num : nums) {
            st.push_back(num);
            while (st.size() >= 2) {
                int a = st[st.size() - 2];
                int b = st[st.size() - 1];
                int g = std::gcd(a, b);
                if (g == 1) break;
                st.pop_back();
                st.pop_back();
                st.push_back((long long)a * b / g);
            }
        }
        return st;
    }
};