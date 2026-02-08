class Solution:
    def minFlips(self, target: str) -> int:
        flips = 0
        current_bit_state = '0'

        for char_target in target:
            if char_target != current_bit_state:
                flips += 1
                if current_bit_state == '0':
                    current_bit_state = '1'
                else:
                    current_bit_state = '0'

        return flips