#include <algorithm> // Required for std::min
#include <vector>    // Required for std::min with initializer list in some compilers, though not strictly for std::min(a, std::min(b, c))

class Solution {
public:
    int distributeMoney(int money, int children) {
        // Condition 1: Each child must receive at least 1 dollar.
        // If money < children, it's impossible to give each child $1.
        if (money < children) {
            return -1;
        }

        // We want to maximize the number of children who receive exactly $8.
        // Let 'k' be this number.

        // Constraint 1: We cannot give $8 to more children than we have.
        // k <= children

        // Constraint 2: We must have enough money to give 'k' children $8.
        // k * 8 <= money  =>  k <= money / 8 (integer division)

        // Constraint 3: After 'k' children receive $8, the remaining 'money - k * 8'
        // must be distributed among the remaining 'children - k' children,
        // with each of them receiving at least $1.
        // So, money - k * 8 >= children - k
        // Rearranging: money - children >= k * 8 - k
        // money - children >= 7 * k
        // k <= (money - children) / 7 (integer division)

        // Combine these constraints to find the maximum possible 'k'.
        int k = std::min({children, money / 8, (money - children) / 7});

        // Special Edge Case:
        // If we found 'k' such that all 'children' receive $8 (i.e., k == children),
        // but there is still money left over (money - k * 8 > 0),
        // then this leftover money must be given to some of these 'k' children.
        // This means at least one child will receive MORE than $8,
        // so not all 'k' children will receive *exactly* $8.
        // In this specific scenario, to maximize children receiving *exactly* $8,
        // we must reduce the count to 'k - 1'.
        // (This implies k-1 children get $8, and one child gets $8 + extra + the $8 that would have gone to one of the k-1 children).
        // This logic also handles the case where children=1, money=10.
        // k = min(1, 10/8=1, (10-1)/7=1) = 1.
        // k == children (1 == 1) is true.
        // money - k*8 > 0 (10 - 1*8 > 0 => 2 > 0) is true.
        // So, k becomes 1 - 1 = 0. Correct (the child gets $10, not $8).
        if (k == children && money - k * 8 > 0) {
            return k - 1;
        }

        return k;
    }
};