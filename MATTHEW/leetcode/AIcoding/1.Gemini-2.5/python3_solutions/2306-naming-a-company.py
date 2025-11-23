import collections

class Solution:
    def distinctNames(self, ideas: list[str]) -> int:
        groups = collections.defaultdict(set)
        for idea in ideas:
            first_char = idea[0]
            suffix = idea[1:]
            groups[first_char].add(suffix)

        total_valid_pairs = 0

        char_keys = list(groups.keys())

        for i in range(len(char_keys)):
            for j in range(len(char_keys)):
                if i == j:
                    continue

                c1 = char_keys[i]
                c2 = char_keys[j]

                suffixes1 = groups[c1]
                suffixes2 = groups[c2]

                common_suffixes = suffixes1.intersection(suffixes2)

                count_A = len(suffixes1) - len(common_suffixes)
                count_B = len(suffixes2) - len(common_suffixes)

                total_valid_pairs += count_A * count_B

        return total_valid_pairs