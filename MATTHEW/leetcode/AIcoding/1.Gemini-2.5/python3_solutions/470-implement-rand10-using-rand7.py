class Solution:
    def rand10(self) -> int:
        while True:
            # Generate a number in the range [1, 49] uniformly.
            # (rand7() - 1) generates 0, 1, ..., 6 with equal probability.
            # (rand7() - 1) * 7 shifts this to 0, 7, ..., 42.
            # Adding another rand7() (which is 1, ..., 7) results in:
            # Min: 0 * 7 + 1 = 1
            # Max: 6 * 7 + 7 = 49
            # All numbers from 1 to 49 are generated with equal probability.
            num = (rand7() - 1) * 7 + rand7()

            # We need numbers from 1 to 10. The largest multiple of 10 less than or equal to 49 is 40.
            # If num is in the range [1, 40], we can map it to [1, 10] uniformly.
            if num <= 40:
                # (num - 1) % 10 maps 1-10 to 0-9, 11-20 to 0-9, etc.
                # Adding 1 converts 0-9 to 1-10.
                return (num - 1) % 10 + 1