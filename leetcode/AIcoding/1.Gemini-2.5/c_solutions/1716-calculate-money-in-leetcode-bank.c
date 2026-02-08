int totalMoney(int n) {
    int total_money = 0;
    int num_full_weeks = n / 7;
    int remaining_days = n % 7;

    // Calculate money for all full weeks
    // For week 'k' (1-indexed), the money saved is k, k+1, ..., k+6
    // The sum for week 'k' is (k + k+6) * 7 / 2 = (2k + 6) * 7 / 2 = (k + 3) * 7
    for (int i = 0; i < num_full_weeks; i++) {
        // 'i' is 0-indexed, so week number is (i + 1)
        total_money += (i + 1 + 3) * 7; // (week_number + 3) * 7
    }

    // Calculate money for the remaining days in the partial week
    // The starting amount for the first day of this partial week (Monday)
    // would be (num_full_weeks + 1)
    for (int i = 0; i < remaining_days; i++) {
        total_money += (num_full_weeks + 1) + i;
    }

    return total_money;
}