class Solution:
    def stoneGameIX(self, stones: list[int]) -> bool:
        cnt0 = 0
        cnt1 = 0
        cnt2 = 0
        for x in stones:
            if x % 3 == 0:
                cnt0 += 1
            elif x % 3 == 1:
                cnt1 += 1
            else:
                cnt2 += 1

        if cnt1 == 0 and cnt2 == 0:
            return False

        if cnt0 % 2 == 0:  # Even number of stones with value % 3 == 0
            # Alice wins if she can ensure Bob is forced to make the sum a multiple of 3.
            # If there are both 1-stones and 2-stones, Alice can always win unless cnt1 == cnt2.
            # If cnt1 == cnt2, Alice picks a 1, Bob picks a 1, Alice picks a 2, Bob picks a 2.
            # This continues until all 1s and 2s are gone. The last stone is picked by Bob, and he loses.
            # No, if cnt1 == cnt2, Alice picks 1, sum=1. Bob picks 1, sum=2. Alice picks 2, sum=1. Bob picks 2, sum=2.
            # This is not right.
            # If cnt1 == cnt2, Alice picks 1. (s=1). Bob picks 2. (s=0). Bob loses. Alice wins.
            # This means if cnt1 > 0 and cnt2 > 0, Alice can always win.
            # The only exception is if cnt1 == 0 or cnt2 == 0.
            # If cnt1 == 0: Alice must pick a 2. Sum = 2. Bob's turn.
            #   Bob picks a 2. Sum = 1. Alice's turn.
            #   Alice picks a 2. Sum = 0. Alice loses. (If cnt2 is odd).
            #   Alice wins if cnt2 is even and cnt2 > 0.
            # If cnt2 == 0: Alice must pick a 1. Sum = 1. Bob's turn.
            #   Bob picks a 1. Sum = 2. Alice's turn.
            #   Alice picks a 1. Sum = 0. Alice loses. (If cnt1 is odd).
            #   Alice wins if cnt1 is even and cnt1 > 0.

            # Correct conditions for cnt0 % 2 == 0:
            # If cnt1 > 0 and cnt2 > 0: Alice wins if cnt1 != cnt2.
            # If cnt1 == 0: Alice wins if cnt2 > 1. (Alice picks 2, Bob picks 2, ... Alice wins if cnt2 is even and > 0)
            # If cnt2 == 0: Alice wins if cnt1 > 1. (Alice picks 1, Bob picks 1, ... Alice wins if cnt1 is even and > 0)

            # This can be simplified:
            # If cnt1 == 0: return cnt2 > 1
            # If cnt2 == 0: return cnt1 > 1
            # If cnt1 > 0 and cnt2 > 0: return abs(cnt1 - cnt2) != 0

            if cnt1 == 0:
                return cnt2 > 1
            if cnt2 == 0:
                return cnt1 > 1
            return abs(cnt1 - cnt2) != 0

        else:  # Odd number of stones with value % 3 == 0
            # Alice can use a 0-stone to pass the turn and make cnt0 even.
            # This effectively swaps the roles of Alice and Bob for the 1- and 2-stones.
            # If cnt1 == 0: Alice wins if cnt2 == 1.
            # If cnt2 == 0: Alice wins if cnt1 == 1.
            # If cnt1 > 0 and cnt2 > 0: Alice wins if abs(cnt1 - cnt2) <= 1.

            if cnt1 == 0:
                return cnt2 == 1
            if cnt2 == 0:
                return cnt1 == 1
            return abs(cnt1 - cnt2) <= 1