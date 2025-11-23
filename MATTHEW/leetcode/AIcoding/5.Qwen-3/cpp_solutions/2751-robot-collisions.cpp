#include <iostream>
#include <vector>
#include <stack>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> survivedRobotsHealths(vector<int>& positions, vector<int>& healths, string& directions) {
        int n = positions.size();
        vector<int> indices(n);
        for (int i = 0; i < n; ++i) {
            indices[i] = i;
        }
        sort(indices.begin(), indices.end(), [&](int a, int b) {
            return positions[a] < positions[b];
        });

        stack<int> st;
        for (int i : indices) {
            if (directions[i] == 'R') {
                st.push(i);
            } else {
                while (!st.empty() && directions[st.top()] == 'R') {
                    int j = st.top();
                    if (healths[j] > healths[i]) {
                        healths[j] -= healths[i];
                        healths[i] = 0;
                        break;
                    } else if (healths[j] < healths[i]) {
                        healths[i] -= healths[j];
                        st.pop();
                    } else {
                        st.pop();
                        healths[i] = 0;
                        break;
                    }
                }
                if (healths[i] > 0) {
                    st.push(i);
                }
            }
        }

        vector<int> result;
        for (int i = 0; i < n; ++i) {
            if (healths[i] > 0) {
                result.push_back(healths[i]);
            }
        }
        return result;
    }
};