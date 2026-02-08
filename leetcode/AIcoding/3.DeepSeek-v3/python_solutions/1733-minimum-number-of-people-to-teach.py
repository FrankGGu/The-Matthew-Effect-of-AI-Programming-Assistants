class Solution:
    def minimumTeachings(self, n: int, languages: List[List[int]], friendships: List[List[int]]) -> int:
        known = [set(lang) for lang in languages]
        need_teach = set()

        for u, v in friendships:
            u_langs = known[u-1]
            v_langs = known[v-1]
            if not u_langs & v_langs:
                need_teach.add(u)
                need_teach.add(v)

        if not need_teach:
            return 0

        lang_counts = [0] * (n + 1)
        for person in need_teach:
            for lang in known[person-1]:
                lang_counts[lang] += 1

        max_known = max(lang_counts)
        return len(need_teach) - max_known