class Solution:
    def powerfulIntegers(self, x: int, y: int, bound: int) -> list[int]:
        powerful_integers = set()

        current_x_power = 1
        while current_x_power <= bound:
            current_y_power = 1
            while current_x_power + current_y_power <= bound:
                powerful_integers.add(current_x_power + current_y_power)
                if y == 1:
                    break
                current_y_power *= y

            if x == 1:
                break
            current_x_power *= x

        return list(powerful_integers)