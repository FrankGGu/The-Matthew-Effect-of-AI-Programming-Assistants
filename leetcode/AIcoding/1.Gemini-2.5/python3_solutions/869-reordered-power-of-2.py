class Solution:
    def reorderedPowerOf2(self, n: int) -> bool:
        def count_digits(num):
            counts = [0] * 10
            s = str(num)
            for char_digit in s:
                counts[int(char_digit)] += 1
            return tuple(counts)

        n_counts = count_digits(n)

        for i in range(31):
            power_of_2 = 1 << i
            power_counts = count_digits(power_of_2)
            if n_counts == power_counts:
                return True

        return False