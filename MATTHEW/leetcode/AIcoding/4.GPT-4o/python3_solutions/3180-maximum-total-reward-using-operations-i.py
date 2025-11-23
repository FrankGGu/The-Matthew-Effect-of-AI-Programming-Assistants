class Solution:
    def maximumTotalReward(self, rewards: List[int], operations: List[List[int]]) -> int:
        n = len(rewards)
        total_reward = sum(rewards)
        modified_rewards = rewards[:]

        for op in operations:
            if op[0] == 1:
                modified_rewards[op[1]] += op[2]
            else:
                modified_rewards[op[1]] -= op[2]

        return sum(max(0, reward) for reward in modified_rewards)