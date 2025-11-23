class Solution:
    def spellChecker(self, wordlist: List[str], queries: List[str]) -> List[str]:
        word_set = set(wordlist)
        lower_word_map = {}
        vowel_variants = {}

        for word in wordlist:
            lower_word = word.lower()
            if lower_word not in lower_word_map:
                lower_word_map[lower_word] = word
            if lower_word not in vowel_variants:
                vowel_variants[lower_word] = word

            if lower_word not in vowel_variants:
                vowel_variants[lower_word] = word

        vowels = set('aeiou')

        def create_variant(word):
            return ''.join(['*' if ch in vowels else ch for ch in word])

        for word in wordlist:
            variant = create_variant(word.lower())
            if variant not in vowel_variants:
                vowel_variants[variant] = word

        result = []
        for query in queries:
            if query in word_set:
                result.append(query)
            elif query.lower() in lower_word_map:
                result.append(lower_word_map[query.lower()])
            else:
                variant = create_variant(query.lower())
                result.append(vowel_variants.get(variant, ""))

        return result