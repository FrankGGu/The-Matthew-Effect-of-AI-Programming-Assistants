class Solution:
    def timeRequiredToBuy(self, tickets: list[int], k: int) -> int:
        n = len(tickets)
        time = 0
        target_tickets = tickets[k]

        for i in range(n):
            if i <= k:
                time += min(tickets[i], target_tickets)
            else:
                time += min(tickets[i], target_tickets - 1)

        return time