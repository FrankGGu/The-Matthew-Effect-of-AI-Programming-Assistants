class Solution:
    def minMoves(self, nums: List[int], k: int) -> int:
        ones = [i for i, num in enumerate(nums) if num == 1]
        if k % 2 == 0:
            median_indices = [k // 2 - 1, k // 2]
            median_values = [ones[k // 2 - 1], ones[k // 2]]
            prefix_sums = [0]
            for i in range(len(ones)):
                prefix_sums.append(prefix_sums[-1] + ones[i])

            def calculate_moves(median_index):
                moves = 0
                median_value = ones[median_index]
                for i in range(k):
                    moves += abs(ones[i] - (median_value - k // 2 + i))
                return moves

            min_moves = float('inf')
            for i in range(len(ones) - k + 1):
                moves = 0
                m = i + k // 2 -1
                median_value = ones[m]
                moves = (median_value * (k//2) - (prefix_sums[i+k//2] - prefix_sums[i])) - ((prefix_sums[i+k] - prefix_sums[i+k//2]) - median_value * (k - k//2))
                min_moves = min(min_moves, moves)
            return min_moves
        else:
            median_index = k // 2
            median_value = ones[median_index]
            prefix_sums = [0]
            for i in range(len(ones)):
                prefix_sums.append(prefix_sums[-1] + ones[i])

            def calculate_moves(median_index):
                moves = 0
                median_value = ones[median_index]
                for i in range(k):
                    moves += abs(ones[i] - (median_value - k // 2 + i))
                return moves

            min_moves = float('inf')
            for i in range(len(ones) - k + 1):
                moves = 0
                m = i + k // 2
                median_value = ones[m]
                moves = (median_value * (k//2) - (prefix_sums[i+k//2] - prefix_sums[i])) - ((prefix_sums[i+k] - prefix_sums[i+k//2+1]) - median_value * (k - k//2 -1))
                min_moves = min(min_moves, moves)
            return min_moves