#include <string>
#include <vector>
#include <numeric>
#include <map>
#include <algorithm>

class Solution {
public:
    int keyboard(std::string target) {
        std::vector<long long> f(26, 0);
        for (char c : target) {
            f[c - 'a']++;
        }

        std::vector<long long> K(26);
        K[0] = 0;
        K[1] = 0;

        for (int i = 0; i < 24; ++i) { // Calculate K_2 to K_25
            // K_{i+2} = f[i+1] - K[i] - K[i+1]
            K[i + 2] = f[i + 1] - K[i] - K[i + 1];
        }

        // The system of equations for x[0] and x[1] using wrap-around conditions:
        // Equation 1 (for f[0]): x[25] + x[0] + x[1] = f[0]
        // Equation 2 (for f[25]): x[24] + x[25] + x[0] = f[25]

        // Substitute x[i] = A_i * x[0] + B_i * x[1] + K_i
        // A_i coefficients: 1, 0, -1, 1, 0, -1, ... (A_0=1, A_1=0, A_2=-1, ...)
        // B_i coefficients: 0, 1, -1, 0, 1, -1, ... (B_0=0, B_1=1, B_2=-1, ...)
        // For i=24: A_24 = 1, B_24 = 0
        // For i=25: A_25 = 0, B_25 = 1

        // Eq 1: (A_25 * x[0] + B_25 * x[1] + K[25]) + x[0] + x[1] = f[0]
        //       (0 * x[0] + 1 * x[1] + K[25]) + x[0] + x[1] = f[0]
        //       x[0] + 2*x[1] = f[0] - K[25]
        long long R1 = f[0] - K[25];

        // Eq 2: (A_24 * x[0] + B_24 * x[1] + K[24]) + (A_25 * x[0] + B_25 * x[1] + K[25]) + x[0] = f[25]
        //       (1 * x[0] + 0 * x[1] + K[24]) + (0 * x[0] + 1 * x[1] + K[25]) + x[0] = f[25]
        //       2*x[0] + x[1] = f[25] - K[24] - K[25]
        long long R2 = f[25] - K[24] - K[25];

        // Solve the system:
        // x[0] + 2*x[1] = R1
        // 2*x[0] + x[1] = R2
        // Multiply first by 2: 2*x[0] + 4*x[1] = 2*R1
        // Subtract second: (2*x[0] + 4*x[1]) - (2*x[0] + x[1]) = 2*R1 - R2
        // 3*x[1] = 2*R1 - R2  => x[1] = (2*R1 - R2) / 3
        // From first eq: x[0] = R1 - 2*x[1]
        // Substitute x[1]: x[0] = R1 - 2*(2*R1 - R2)/3 = (3*R1 - 4*R1 + 2*R2)/3 = (2*R2 - R1)/3

        if ((2 * R1 - R2) % 3 != 0 || (2 * R2 - R1) % 3 != 0) {
            return -1; // No integer solution for x[0], x[1]
        }

        long long x0 = (2 * R2 - R1) / 3;
        long long x1 = (2 * R1 - R2) / 3;

        if (x0 < 0 || x1 < 0) {
            return -1; // Number of presses cannot be negative
        }

        std::vector<long long> x(26);
        x[0] = x0;
        x[1] = x1;

        long long total_presses = x0 + x1;

        for (int i = 2; i < 26; ++i) {
            // Calculate A_i and B_i based on i % 3
            long long Ai, Bi;
            if (i % 3 == 0) { // e.g., A_0, A_3, ...
                Ai = 1; Bi = 0;
            } else if (i % 3 == 1) { // e.g., A_1, A_4, ...
                Ai = 0; Bi = 1;
            } else { // i % 3 == 2, e.g., A_2, A_5, ...
                Ai = -1; Bi = -1;
            }

            x[i] = Ai * x[0] + Bi * x[1] + K[i];

            if (x[i] < 0) {
                return -1; // Number of presses cannot be negative
            }
            total_presses += x[i];
        }

        return total_presses;
    }
};