class Solution:
    def minimumTeachings(self, n: int, m: int, languages: list[list[int]], friendships: list[list[int]]) -> int:
        user_languages_sets = [set(langs) for langs in languages]

        uncommunicative_users = set()
        for u, v in friendships:
            u_idx = u - 1
            v_idx = v - 1

            if user_languages_sets[u_idx].isdisjoint(user_languages_sets[v_idx]):
                uncommunicative_users.add(u_idx)
                uncommunicative_users.add(v_idx)

        if not uncommunicative_users:
            return 0

        min_teachers = float('inf')

        for lang_to_teach in range(1, m + 1):
            current_teachers = 0
            for user_idx in uncommunicative_users:
                if lang_to_teach not in user_languages_sets[user_idx]:
                    current_teachers += 1

            min_teachers = min(min_teachers, current_teachers)

        return min_teachers