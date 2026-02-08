class Solution:
    def lastVisitedIntegers(self, words: list[str]) -> list[int]:
        visited_integers = []
        result = []
        consecutive_prev_count = 0

        for word in words:
            if word == "prev":
                consecutive_prev_count += 1
                if consecutive_prev_count <= len(visited_integers):
                    result.append(visited_integers[len(visited_integers) - consecutive_prev_count])
                else:
                    result.append(-1)
            else:
                visited_integers.append(int(word))
                consecutive_prev_count = 0

        return result