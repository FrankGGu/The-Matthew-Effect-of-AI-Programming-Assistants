class Solution:
    def minPeople(self, n: int, languages: list[list[int]], friendships: list[list[int]]) -> int:
        def can_communicate(person1, person2):
            languages1 = set(languages[person1 - 1])
            languages2 = set(languages[person2 - 1])
            return not languages1.isdisjoint(languages2)

        need_teach = set()
        for u, v in friendships:
            if not can_communicate(u, v):
                need_teach.add((u, v))

        min_people = float('inf')
        for language in range(1, n + 1):
            people_to_teach = set()
            for u, v in need_teach:
                lang_u = language in languages[u - 1]
                lang_v = language in languages[v - 1]
                if not lang_u and not lang_v:
                    people_to_teach.add(u)
                    people_to_teach.add(v)
            count = 0
            languages_to_add = [set() for _ in range(len(languages))]
            for p in people_to_teach:
                languages_to_add[p - 1].add(language)

            temp_need_teach = set()
            for u, v in friendships:

                languages1 = set(languages[u - 1]) | languages_to_add[u-1]
                languages2 = set(languages[v - 1]) | languages_to_add[v-1]
                if languages1.isdisjoint(languages2):
                    temp_need_teach.add((u, v))

            temp_people_to_teach = set()
            for u, v in need_teach:
                lang_u = language in languages[u - 1]
                lang_v = language in languages[v - 1]
                if not lang_u and not lang_v:
                    temp_people_to_teach.add(u)
                    temp_people_to_teach.add(v)

            count = len(set(temp_people_to_teach))
            min_people = min(min_people, count)

        result = float('inf')
        for lang in range(1, n + 1):
            count = 0
            people = set()
            for u, v in need_teach:
                lang_u = lang in languages[u - 1]
                lang_v = lang in languages[v - 1]
                if not lang_u and not lang_v:
                    people.add(u)
                    people.add(v)
            result = min(result, len(people))

        return result