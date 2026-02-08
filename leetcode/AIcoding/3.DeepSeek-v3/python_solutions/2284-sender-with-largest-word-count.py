class Solution:
    def largestWordCount(self, messages: List[str], senders: List[str]) -> str:
        sender_word_count = {}

        for i in range(len(messages)):
            sender = senders[i]
            word_count = len(messages[i].split())
            if sender in sender_word_count:
                sender_word_count[sender] += word_count
            else:
                sender_word_count[sender] = word_count

        max_count = -1
        result = ""
        for sender in sender_word_count:
            if sender_word_count[sender] > max_count:
                max_count = sender_word_count[sender]
                result = sender
            elif sender_word_count[sender] == max_count:
                if sender > result:
                    result = sender

        return result