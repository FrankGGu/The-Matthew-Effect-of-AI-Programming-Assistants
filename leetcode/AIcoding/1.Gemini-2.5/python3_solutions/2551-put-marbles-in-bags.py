class Solution:
    def putMarbles(self, weights: list[int], k: int) -> int:
        n = len(weights)

        potential_cut_costs = []
        for i in range(n - 1):
            potential_cut_costs.append(weights[i] + weights[i+1])

        potential_cut_costs.sort()

        max_sum_of_chosen_cuts = sum(potential_cut_costs[-(k-1):])

        min_sum_of_chosen_cuts = sum(potential_cut_costs[:k-1])

        return max_sum_of_chosen_cuts - min_sum_of_chosen_cuts