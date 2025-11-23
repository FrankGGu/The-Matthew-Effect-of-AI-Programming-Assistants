class Solution:
    def numOfWays(self, n: int) -> int:
        MOD = 10**9 + 7

        # dp_aaa represents the number of ways to paint a grid of height i,
        # where the last row is of type 'aaa' (e.g., RGB, all three colors distinct)
        # dp_aba represents the number of ways to paint a grid of height i,
        # where the last row is of type 'aba' (e.g., RGR, two distinct colors with ends same)

        # For n = 1:
        # There are 6 patterns of type 'aaa' (e.g., RGB, RBG, GRB, GBR, BRG, BGR)
        # There are 6 patterns of type 'aba' (e.g., RGR, RBR, GRG, GBG, BRB, BGB)
        dp_aaa = 6
        dp_aba = 6

        # Iterate from n=2 up to the given n
        for _ in range(2, n + 1):
            # Calculate next_dp_aaa:
            # If the previous row was 'aaa' type, 3 'aaa' patterns can follow.
            # If the previous row was 'aba' type, 2 'aaa' patterns can follow.
            next_dp_aaa = (dp_aaa * 3 + dp_aba * 2) % MOD

            # Calculate next_dp_aba:
            # If the previous row was 'aaa' type, 3 'aba' patterns can follow.
            # If the previous row was 'aba' type, 4 'aba' patterns can follow.
            next_dp_aba = (dp_aaa * 3 + dp_aba * 4) % MOD

            # Update dp values for the next iteration
            dp_aaa = next_dp_aaa
            dp_aba = next_dp_aba

        # The total number of ways for n rows is the sum of ways ending in 'aaa' and 'aba' patterns
        return (dp_aaa + dp_aba) % MOD