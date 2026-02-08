class Solution:
    def report_spam(self, messages: List[str]) -> List[str]:
        spam_words = {"buy", "cheap", "click", "discount", "earn", "free", "offer", "price", "promo", "quote", "save", "win", "winner"}
        spam_messages = []

        for message in messages:
            words = message.lower().split()
            spam_count = 0
            total_words = len(words)

            if total_words == 0:
                continue

            for word in words:
                if word in spam_words:
                    spam_count += 1

            if spam_count / total_words > 0.5:
                spam_messages.append(message)

        return spam_messages