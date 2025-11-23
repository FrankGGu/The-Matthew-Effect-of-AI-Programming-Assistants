#include <vector>
#include <stack>

class Solution {
public:
    std::vector<double> getCollisionTimes(std::vector<std::vector<int>>& cars) {
        int n = cars.size();
        std::vector<double> answer(n, -1.0);
        std::stack<int> st; // Stores indices of cars

        // Iterate from the last car to the first car
        for (int i = n - 1; i >= 0; --i) {
            int p_i = cars[i][0];
            int s_i = cars[i][1];

            // While stack is not empty
            while (!st.empty()) {
                int j = st.top();
                int p_j = cars[j][0];
                int s_j = cars[j][1];

                // Case 1: Current car i is slower or same speed as car j (on top of stack).
                // Car i can never catch car j (or the fleet j represents).
                // Car j effectively blocks car i from any cars further ahead.
                if (s_i <= s_j) {
                    break; 
                }

                // Case 2: Current car i is faster than car j. Collision is possible.
                // Calculate time for car i to collide with car j.
                // Use double for calculation to maintain precision.
                double t_ij = static_cast<double>(p_j - p_i) / (s_i - s_j);

                // Check if car j itself will merge with a car k (in front of j)
                // BEFORE or AT THE SAME TIME car i would merge with car j.
                // If answer[j] is -1.0, it means car j never merges with anything in front.
                // So the condition `answer[j] != -1.0 && t_ij >= answer[j]` will be false.
                // If answer[j] is not -1.0, it's the time j merges with k.
                // If t_ij >= answer[j], it means j merges with k first (or simultaneously).
                // In this case, car i should consider merging with the fleet (j,k) which moves at s_k.
                // By popping j, we effectively remove j as a distinct target, and the next iteration
                // will consider the car k (which was behind j on the stack).
                if (answer[j] != -1.0 && t_ij >= answer[j]) {
                    st.pop();
                } else {
                    // Car i merges with car j (or the fleet j represents) first.
                    // This is the collision time for car i.
                    answer[i] = t_ij;
                    break; // Found the collision time for car i, move to the next car (i-1).
                }
            }

            // Push current car i onto the stack.
            // It might be a target for cars behind it.
            st.push(i);
        }

        return answer;
    }
};