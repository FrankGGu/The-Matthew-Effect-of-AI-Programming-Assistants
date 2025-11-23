class Solution {
public:
    vector<int> survivedRobotsHealths(vector<int>& positions, vector<int>& healths, string directions) {
        int n = positions.size();
        vector<int> indices(n);
        iota(indices.begin(), indices.end(), 0);
        sort(indices.begin(), indices.end(), [&](int a, int b) {
            return positions[a] < positions[b];
        });

        stack<int> st;
        for (int i : indices) {
            if (directions[i] == 'R') {
                st.push(i);
                continue;
            }

            while (!st.empty() && directions[st.top()] == 'R') {
                int top = st.top();
                if (healths[top] == healths[i]) {
                    healths[top] = 0;
                    healths[i] = 0;
                    st.pop();
                    break;
                } else if (healths[top] > healths[i]) {
                    healths[top]--;
                    healths[i] = 0;
                    break;
                } else {
                    healths[i]--;
                    healths[top] = 0;
                    st.pop();
                }
            }
            if (healths[i] > 0) {
                st.push(i);
            }
        }

        vector<int> result;
        for (int h : healths) {
            if (h > 0) {
                result.push_back(h);
            }
        }
        return result;
    }
};