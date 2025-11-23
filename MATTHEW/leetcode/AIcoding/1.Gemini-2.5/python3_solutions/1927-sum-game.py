class Solution:
    def sumGame(self, num: str) -> bool:
        n = len(num)
        half = n // 2

        s1_val = 0
        q1_count = 0
        for i in range(half):
            if num[i] == '?':
                q1_count += 1
            else:
                s1_val += int(num[i])

        s2_val = 0
        q2_count = 0
        for i in range(half, n):
            if num[i] == '?':
                q2_count += 1
            else:
                s2_val += int(num[i])

        initial_diff = s1_val - s2_val
        q_diff = q1_count - q2_count

        if q_diff == 0:
            # If the number of '?'s in both halves is equal, Bob can always mirror Alice's moves
            # to cancel out their effects on the difference.
            # For example, if Alice places 'd' in the first half, Bob can place 'd' in the second half.
            # This ensures that the sum of digits placed in the first half's '?'s equals
            # the sum of digits placed in the second half's '?'s.
            # Thus, the final difference will be equal to the initial difference.
            # Bob wins if the final difference is 0. Alice wins if it's not 0.
            return initial_diff != 0

        # If q_diff != 0, there's an unequal number of '?'s.
        # Bob can still mirror Alice's moves for min(q1_count, q2_count) pairs of '?'s.
        # After these paired '?'s are filled, their net effect on the difference (s1_final - s2_final) is zero.
        # The game then continues with abs(q_diff) remaining '?'s, all located in one half.
        # Alice makes (abs(q_diff) + 1) // 2 moves on these remaining '?'s.
        # Bob makes abs(q_diff) // 2 moves on these remaining '?'s.

        if q_diff > 0: # More '?'s in the first half (q1_count > q2_count)
            # The remaining q_diff '?'s are all in the first half.
            # Alice wants to maximize the final difference, so she places '9's.
            # Bob wants to minimize the final difference, so he places '0's.
            # Each of Alice's moves adds 9 to s1_val (and thus to s1_val - s2_val).
            # Each of Bob's moves adds 0 to s1_val (and thus to s1_val - s2_val).
            alice_contribution = 9 * ((q_diff + 1) // 2)
            bob_contribution = 0 * (q_diff // 2)

            final_diff = initial_diff + alice_contribution + bob_contribution
            return final_diff != 0
        else: # q_diff < 0, More '?'s in the second half (q2_count > q1_count)
            # The remaining abs(q_diff) '?'s are all in the second half.
            # Let abs_q_diff = -q_diff.
            # Alice wants to maximize the final difference, so she places '0's in the second half
            # (to minimize s2_val and thus maximize s1_val - s2_val).
            # Bob wants to minimize the final difference, so he places '9's in the second half
            # (to maximize s2_val and thus minimize s1_val - s2_val).
            # Each of Alice's moves adds 0 to s2_val (and thus subtracts 0 from s1_val - s2_val).
            # Each of Bob's moves adds 9 to s2_val (and thus subtracts 9 from s1_val - s2_val).
            abs_q_diff = -q_diff
            alice_contribution = 0 * ((abs_q_diff + 1) // 2)
            bob_contribution = -9 * (abs_q_diff // 2)

            final_diff = initial_diff + alice_contribution + bob_contribution
            return final_diff != 0