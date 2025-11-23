int distributeMoney(int money, int children) {
    if (money < children) {
        return 0; // Not enough money to give each child at least $1
    }

    if (money == children) {
        return 0; // Each child gets exactly $1, so no one gets $8
    }

    // Attempt to give one child $8
    // If we can't even give $8 to one child, then 0 children get $8
    if (money < 8) {
        return 0;
    }

    // Try to give one child $8
    int remaining_money = money - 8;
    int remaining_children = children - 1;

    // If there are no children left, then one child successfully received $8
    if (remaining_children == 0) {
        return 1;
    }

    // If there are remaining children, they must receive distinct amounts, all at least $1, and none of them $8.
    // Calculate the minimum money required for these remaining children.
    long long min_sum_for_remaining = 0;
    int current_val = 1;
    for (int i = 0; i < remaining_children; i++) {
        if (current_val == 8) {
            current_val++; // Skip $8 to ensure distinct amounts and no child gets $8
        }
        min_sum_for_remaining += current_val;
        current_val++;
    }

    // If we have enough money for the remaining children to satisfy their conditions,
    // then it's possible for one child to get $8.
    if (remaining_money >= min_sum_for_remaining) {
        return 1;
    } else {
        // Not enough money for the remaining children to get distinct amounts (none $8).
        // So, we cannot give one child $8.
        return 0;
    }
}