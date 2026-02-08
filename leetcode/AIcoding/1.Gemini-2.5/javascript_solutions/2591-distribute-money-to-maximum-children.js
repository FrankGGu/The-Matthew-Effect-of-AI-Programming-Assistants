var distributeMoney = function(money, children) {
    // If there's not enough money to give each child at least $1,
    // it's impossible to satisfy the conditions, so 0 children can receive $8.
    if (money < children) {
        return 0;
    }

    // Iterate downwards from the maximum possible number of children who could receive $8.
    // The maximum is limited by:
    // 1. The total number of children (`children`).
    // 2. The total money available divided by $8 (`money / 8`).
    for (let k = Math.min(children, Math.floor(money / 8)); k >= 0; k--) {
        let remainingMoney = money - k * 8;
        let remainingChildren = children - k;

        // Condition 1: Check if there's enough money to give at least $1 to each of the remaining children.
        // If not, this 'k' is too high. Since we are iterating downwards, we continue to a smaller 'k'.
        if (remainingMoney < remainingChildren) {
            continue;
        }

        // Condition 2: Check for the problematic case where a child would be forced to receive exactly $4.
        // This occurs if there is exactly one remaining child and exactly $4 remaining money.
        // If this situation arises, this 'k' is invalid, and we continue to a smaller 'k'.
        if (remainingMoney === 4 && remainingChildren === 1) {
            continue;
        }

        // If both conditions are met, this 'k' represents a valid distribution
        // where 'k' children receive $8, and the remaining money can be distributed
        // among the remaining children such that each gets at least $1 and none gets $4.
        // Since we iterate downwards, the first 'k' we find is the maximum possible.
        return k;
    }

    // This line should theoretically only be reached if the initial money < children check
    // was not sufficient for some edge case, or if no valid distribution (even for k=0) exists.
    // Given the problem constraints and logic, k=0 should always be reachable unless
    // money < children or money=4, children=1 (which are handled correctly by the loop).
    return 0;
};