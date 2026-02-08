def largestWordCount(messages: List[str], senders: List[str]) -> str:
    from collections import defaultdict

    count = defaultdict(int)

    for message, sender in zip(messages, senders):
        count[sender] += len(message.split())

    return max(count, key=lambda x: (count[x], x))