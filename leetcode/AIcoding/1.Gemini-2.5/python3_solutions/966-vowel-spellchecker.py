class Solution:
    def spellchecker(self, wordlist: list[str], queries: list[str]) -> list[str]:
        word_set = set(wordlist)

        lower_to_original = {}
        for word in wordlist:
            lower_word = word.lower()
            if lower_word not in lower_to_original:
                lower_to_original[lower_word] = word

        def devowel(word):
            ans = []
            vowels = "aeiou"
            for char in word.lower():
                if char in vowels:
                    ans.append('#')
                else:
                    ans.append(char)
            return "".join(ans)

        vowel_to_original = {}
        for word in wordlist:
            transformed_word = devowel(word)
            if transformed_word not in vowel_to_original:
                vowel_to_original[transformed_word] = word

        results = []
        for query in queries:
            if query in word_set:
                results.append(query)
                continue

            lower_query = query.lower()
            if lower_query in lower_to_original:
                results.append(lower_to_original[lower_query])
                continue

            transformed_query = devowel(query)
            if transformed_query in vowel_to_original:
                results.append(vowel_to_original[transformed_query])
                continue

            results.append("")

        return results