class Solution:
    def chalkboardXORGame(self, nums: list[int]) -> bool:
        xor_sum = 0
        for num in nums:
            xor_sum ^= num

        if xor_sum == 0:
            return True
        else:
            # If the XOR sum is not 0, Alice wins if and only if the number of elements is even.
            # This is a standard result for this type of impartial game.
            # If N is odd, any move Alice makes leads to a state with N-1 (even) elements.
            # From such a state, Bob (the next player) can always make a non-losing move
            # that leads to a state with N-2 (odd) elements, which is a losing position for Alice.
            # If N is even, Alice can always make a non-losing move to a state with N-1 (odd) elements,
            # which is a losing position for Bob.
            return len(nums) % 2 == 0