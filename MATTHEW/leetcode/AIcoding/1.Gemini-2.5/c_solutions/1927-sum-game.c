#include <stdbool.h>
#include <string.h>
#include <stdlib.h> // For abs

bool sumGame(char * s){
    int n = strlen(s);
    int half_n = n / 2;

    int left_sum = 0;
    int right_sum = 0;
    int left_q = 0;
    int right_q = 0;

    for (int i = 0; i < half_n; i++) {
        if (s[i] == '?') {
            left_q++;
        } else {
            left_sum += s[i] - '0';
        }
    }

    for (int i = half_n; i < n; i++) {
        if (s[i] == '?') {
            right_q++;
        } else {
            right_sum += s[i] - '0';
        }
    }

    int diff_sum = left_sum - right_sum;
    int diff_q = left_q - right_q;

    // Alice wants sum1 == sum2, which means sum1 - sum2 == 0.
    // Bob wants sum1 != sum2, which means sum1 - sum2 != 0.
    // Alice goes first. Both play optimally.

    // The game can be simplified by considering the initial sum difference (diff_sum)
    // and the difference in the number of question marks (diff_q).
    // Each '?' in the left half, if filled with digit 'd', increases diff_sum by 'd'.
    // Each '?' in the right half, if filled with digit 'd', decreases diff_sum by 'd'.

    // The key insight for these types of games is that the players try to influence the final difference.
    // Alice tries to make the final difference 0.
    // Bob tries to make the final difference non-zero.

    // Consider the net effect of all question marks.
    // Alice and Bob take turns filling '?'s.
    // Alice wants to choose digits to balance the sum. Bob wants to unbalance it.
    // Bob's optimal strategy is to use '9' to maximize the absolute difference or '0' to minimize it,
    // depending on which direction helps him make the final sum non-zero.
    // Alice's optimal strategy is to use '0' or '9' to try to make the final sum exactly zero.

    // The total effect of the '?'s on the sum difference can be simplified.
    // If diff_q > 0 (more '?'s on the left), Bob will try to increase the sum difference by filling '?'s with 9.
    // If diff_q < 0 (more '?'s on the right), Bob will try to decrease the sum difference by filling '?'s with 9.
    // Alice will try to counter Bob by filling her '?'s with 0.

    // The number of "net" moves Bob gets to make to influence the difference is `diff_q / 2`.
    // In C, integer division `diff_q / 2` truncates towards zero.
    // For positive `diff_q`, it acts as `floor(diff_q / 2.0)`.
    // For negative `diff_q`, it acts as `ceil(diff_q / 2.0)`.
    // This value represents the number of pairs of question marks in the "excess" half that Bob can effectively control to maximize the difference.
    // Each such move by Bob will contribute 9 to the difference (or -9 if on the right side).

    // Alice wins if the initial sum difference can be perfectly offset by Bob's maximum influence.
    // This means `diff_sum + (diff_q / 2) * 9 == 0`.

    return diff_sum + (diff_q / 2) * 9 == 0;
}