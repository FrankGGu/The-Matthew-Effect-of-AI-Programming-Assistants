import collections

class Solution:
    def minimumRounds(self, tasks: list[int]) -> int:
        counts = collections.Counter(tasks)

        total_rounds = 0
        for count in counts.values():
            if count == 1:
                return -1

            # For any count >= 2, we can always complete tasks.
            # We want to minimize rounds, which means maximizing the use of 3-task rounds.
            # Let count = 3q + r, where r is 0, 1, or 2.
            # If r = 0: count = 3q. Rounds = q.
            # If r = 1: count = 3q + 1. We must convert one 3-task round into two 2-task rounds.
            #           So, count = 3(q-1) + 4. Rounds = (q-1) + 2 = q + 1.
            #           (This is only possible if q >= 1, i.e., count >= 4. If count=1, it's impossible, handled above.)
            # If r = 2: count = 3q + 2. Rounds = q + 1.
            #
            # All these cases can be covered by the formula (count + 2) // 3 using integer division.
            # Example: count = 6 (r=0) -> (6+2)//3 = 8//3 = 2. Correct.
            # Example: count = 4 (r=1) -> (4+2)//3 = 6//3 = 2. Correct.
            # Example: count = 7 (r=1) -> (7+2)//3 = 9//3 = 3. Correct.
            # Example: count = 2 (r=2) -> (2+2)//3 = 4//3 = 1. Correct.
            # Example: count = 5 (r=2) -> (5+2)//3 = 7//3 = 2. Correct.

            total_rounds += (count + 2) // 3

        return total_rounds