class Solution:
    def countTriplets(self, arr: List[int]) -> int:
        n = len(arr)
        prefix_xor = [0] * (n + 1)

        for i in range(n):
            prefix_xor[i + 1] = prefix_xor[i] ^ arr[i]

        count = 0
        xor_set = set()

        for i in range(n):
            for j in range(i + 1, n):
                current_xor = prefix_xor[j + 1] ^ prefix_xor[i]
                if current_xor not in xor_set:
                    xor_set.add(current_xor)
                    count += 1

        return count