class Solution:
    def mergeTriplets(self, triplets: List[List[int]], target: List[int]) -> bool:
        max_triplet = [0, 0, 0]
        for triplet in triplets:
            if all(t <= ta for t, ta in zip(triplet, target)):
                max_triplet = [max(max_triplet[i], triplet[i]) for i in range(3)]
        return max_triplet == target