class Solution:
    def getMaxGridHappiness(self, m: int, n: int, introverts: int, extroverts: int) -> int:

        memo = {}

        powers_of_3 = [1] * (n + 1)
        for k in range(1, n + 1):
            powers_of_3[k] = powers_of_3[k-1] * 3

        def get_person_at_mask_pos(mask, k):
            return (mask // powers_of_3[k]) % 3

        def solve(idx, i_rem, e_rem, mask):
            state = (idx, i_rem, e_rem, mask)
            if state in memo:
                return memo[state]

            if idx == m * n:
                return 0

            r = idx // n
            c = idx % n

            res = 0

            # Option 1: Place nothing (person_type = 0)
            next_mask_empty = mask - get_person_at_mask_pos(mask, c) * powers_of_3[c]
            next_mask_empty = next_mask_empty + 0 * powers_of_3[c]
            res = max(res, solve(idx + 1, i_rem, e_rem, next_mask_empty))

            # Option 2: Place an introvert (person_type = 1)
            if i_rem > 0:
                h_intro = 120
                curr_person_type = 1

                if c > 0:
                    left_person = get_person_at_mask_pos(mask, c - 1)
                    if left_person != 0:
                        h_intro -= 30

                up_person = get_person_at_mask_pos(mask, c)
                if up_person != 0:
                    h_intro -= 30

                next_mask_intro = mask - get_person_at_mask_pos(mask, c) * powers_of_3[c]
                next_mask_intro = next_mask_intro + curr_person_type * powers_of_3[c]
                res = max(res, h_intro + solve(idx + 1, i_rem - 1, e_rem, next_mask_intro))

            # Option 3: Place an extrovert (person_type = 2)
            if e_rem > 0:
                h_extro = 40
                curr_person_type = 2

                if c > 0:
                    left_person = get_person_at_mask_pos(mask, c - 1)
                    if left_person != 0:
                        h_extro += 20

                up_person = get_person_at_mask_pos(mask, c)
                if up_person != 0:
                    h_extro += 20

                next_mask_extro = mask - get_person_at_mask_pos(mask, c) * powers_of_3[c]
                next_mask_extro = next_mask_extro + curr_person_type * powers_of_3[c]
                res = max(res, h_extro + solve(idx + 1, i_rem, e_rem - 1, next_mask_extro))

            memo[state] = res
            return res

        return solve(0, introverts, extroverts, 0)