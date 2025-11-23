def timeRequiredToBuy(tickets: List[int], k: int) -> int:
    return sum(min(tickets[i], tickets[k]) for i in range(len(tickets))) + max(0, tickets[k] - tickets[k])