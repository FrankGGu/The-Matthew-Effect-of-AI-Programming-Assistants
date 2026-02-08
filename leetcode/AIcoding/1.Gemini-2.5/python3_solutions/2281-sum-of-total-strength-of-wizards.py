class Solution:
    def totalStrength(self, strength: list[int]) -> int:
        n = len(strength)
        MOD = 10**9 + 7

        # Calculate prefix sums P
        # P[k] = sum(strength[0...k-1])
        # P[0] = 0
        P = [0] * (n + 1)
        for i in range(n):
            P[i+1] = (P[i] + strength[i]) % MOD

        # Calculate prefix sums of prefix sums PP
        # PP[k] = sum(P[0...k-1])
        # PP[0] = 0
        PP = [0] * (n + 2)
        for i in range(n + 1):
            PP[i+1] = (PP[i] + P[i]) % MOD

        # Calculate L: index of nearest element to the left strictly smaller than strength[i]
        # If no such element, L[i] = -1
        L = [-1] * n
        stack = [] # Stores indices
        for i in range(n):
            while stack and strength[stack[-1]] >= strength[i]:
                stack.pop()
            if stack:
                L[i] = stack[-1]
            stack.append(i)

        # Calculate R: index of nearest element to the right smaller than or equal to strength[i]
        # If no such element, R[i] = n
        R = [n] * n
        stack = [] # Stores indices
        for i in range(n - 1, -1, -1):
            while stack and strength[stack[-1]] > strength[i]: # Use > to handle duplicates: current i takes precedence
                stack.pop()
            if stack:
                R[i] = stack[-1]
            stack.append(i)

        total_strength_sum = 0

        for i in range(n):
            left_bound = L[i]
            right_bound = R[i]

            # The number of choices for starting index j is (i - left_bound)
            # The number of choices for ending index k is (right_bound - i)

            # Sum of P[k+1] for k from i to right_bound-1
            # This is sum_{k=i}^{right_bound-1} P[k+1] = PP[right_bound+1] - PP[i+1]
            sum_P_k_plus_1 = (PP[right_bound + 1] - PP[i + 1] + MOD) % MOD

            # Sum of P[j] for j from left_bound+1 to i
            # This is sum_{j=left_bound+1}^{i} P[j] = PP[i+1] - PP[left_bound+1]
            sum_P_j = (PP[i + 1] - PP[left_bound + 1] + MOD) % MOD

            # Contribution for strength[i]
            # (i - left_bound) * sum_{k=i}^{right_bound-1} P[k+1]
            term1 = ((i - left_bound) % MOD * sum_P_k_plus_1) % MOD

            # (right_bound - i) * sum_{j=left_bound+1}^{i} P[j]
            term2 = ((right_bound - i) % MOD * sum_P_j) % MOD

            # Total sum of (P[k+1] - P[j]) for all valid j, k
            contribution_factor = (term1 - term2 + MOD) % MOD

            # Add strength[i] * contribution_factor to total sum
            total_strength_sum = (total_strength_sum + (strength[i] * contribution_factor) % MOD) % MOD

        return total_strength_sum