class Solution:
    def largestWordCount(self, messages: List[str], senders: List[str]) -> str:
        counts = {}
        for i in range(len(messages)):
            count = len(messages[i].split())
            if senders[i] in counts:
                counts[senders[i]] += count
            else:
                counts[senders[i]] = count

        max_count = 0
        result = ""
        for sender, count in counts.items():
            if count > max_count:
                max_count = count
                result = sender
            elif count == max_count:
                if sender > result:
                    result = sender

        return result