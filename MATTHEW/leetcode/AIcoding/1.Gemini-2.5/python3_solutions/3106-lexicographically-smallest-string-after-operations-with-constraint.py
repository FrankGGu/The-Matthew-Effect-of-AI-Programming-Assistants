import math

class Solution:
    def getSmallestString(self, s: str, k: int, x: int) -> str:
        n = len(s)
        s_list = list(s)
        result = []

        for i in range(n):
            best_char = 'z'
            best_char_idx_in_s = -1
            min_total_cost = math.inf
            min_inc_cost = math.inf

            # Iterate through all remaining characters in s_list
            for j in range(len(s_list)):
                char_to_consider = s_list[j]

                # Cost to move s_list[j] to the current position (i)
                # This is simply 'j' swaps because s_list is effectively the remaining part of the string.
                swaps_cost = j

                if swaps_cost > k:
                    continue

                # Iterate through all possible target characters ('a' to 'z')
                for target_ord in range(ord('a'), ord('z') + 1):
                    target_ch = chr(target_ord)

                    # Cost to increment/decrement char_to_consider to target_ch
                    # This is the number of increments needed to reach target_ch from char_to_consider
                    # (ord(char_to_consider) - target_ord + 26) % 26 gives the minimum increments
                    # to make char_to_consider into target_ch.
                    inc_cost = (ord(char_to_consider) - target_ord + 26) % 26

                    if inc_cost > x:
                        continue

                    total_cost = swaps_cost + inc_cost
                    if total_cost > k:
                        continue

                    # Tie-breaking logic:
                    # 1. Prefer lexicographically smaller character
                    # 2. If characters are same, prefer smaller total_cost (leaves more k)
                    # 3. If total_cost is same, prefer smaller inc_cost (leaves more x)
                    if target_ch < best_char:
                        best_char = target_ch
                        best_char_idx_in_s = j
                        min_total_cost = total_cost
                        min_inc_cost = inc_cost
                    elif target_ch == best_char:
                        if total_cost < min_total_cost:
                            best_char_idx_in_s = j
                            min_total_cost = total_cost
                            min_inc_cost = inc_cost
                        elif total_cost == min_total_cost:
                            if inc_cost < min_inc_cost:
                                best_char_idx_in_s = j
                                min_inc_cost = inc_cost

            # Append the chosen character to the result
            result.append(best_char)

            # Deduct costs
            k -= min_total_cost
            x -= min_inc_cost

            # Remove the chosen character from the s_list
            s_list.pop(best_char_idx_in_s)

        return "".join(result)