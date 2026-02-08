from collections import defaultdict

class Solution:
    def largestWordCount(self, messages: list[str], senders: list[str]) -> str:
        sender_word_counts = defaultdict(int)

        for i in range(len(messages)):
            message = messages[i]
            sender = senders[i]
            word_count = len(message.split())
            sender_word_counts[sender] += word_count

        max_word_count = -1
        result_sender = ""

        for sender, count in sender_word_counts.items():
            if count > max_word_count:
                max_word_count = count
                result_sender = sender
            elif count == max_word_count:
                if sender > result_sender:
                    result_sender = sender

        return result_sender