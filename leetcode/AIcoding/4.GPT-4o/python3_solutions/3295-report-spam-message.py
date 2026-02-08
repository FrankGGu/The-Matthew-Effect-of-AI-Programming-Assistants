class Solution:
    def reportSpam(self, messages: List[str], spamWords: List[str]) -> List[str]:
        spam_set = set(spamWords)
        result = []
        for message in messages:
            if any(word in spam_set for word in message.split()):
                result.append("Spam")
            else:
                result.append("Not Spam")
        return result