class Solution:
    def getDoubleModularExponentiation(self, queries: list[list[int]]) -> list[int]:
        results = []
        for b, e, m1, m2 in queries:
            intermediate_base = b % m1
            final_result = pow(intermediate_base, e, m2)
            results.append(final_result)
        return results