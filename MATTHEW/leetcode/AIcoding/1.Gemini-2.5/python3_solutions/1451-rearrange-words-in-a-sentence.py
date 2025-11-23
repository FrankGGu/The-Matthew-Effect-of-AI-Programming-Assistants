class Solution:
    def rearrangeWords(self, text: str) -> str:
        words = text.lower().split()

        indexed_words = []
        for i, word in enumerate(words):
            indexed_words.append((word, i))

        indexed_words.sort(key=lambda x: (len(x[0]), x[1]))

        result_words = [item[0] for item in indexed_words]

        result_sentence = " ".join(result_words)

        return result_sentence.capitalize()