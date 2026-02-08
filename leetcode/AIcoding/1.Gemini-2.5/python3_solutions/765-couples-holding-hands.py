class Solution:
    def minSwapsCouples(self, row: list[int]) -> int:
        n = len(row)
        pos = [0] * n
        for i in range(n):
            pos[row[i]] = i

        swaps = 0
        for i in range(0, n, 2):
            p1 = row[i]
            partner_p1 = p1 ^ 1

            p2 = row[i+1]

            if p2 == partner_p1:
                continue
            else:
                idx_partner_p1 = pos[partner_p1]

                person_at_i_plus_1 = row[i+1]

                row[idx_partner_p1] = person_at_i_plus_1
                row[i+1] = partner_p1

                pos[person_at_i_plus_1] = idx_partner_p1
                pos[partner_p1] = i + 1

                swaps += 1

        return swaps