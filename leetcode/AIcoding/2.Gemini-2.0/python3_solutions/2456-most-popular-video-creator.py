from collections import defaultdict

class Solution:
    def mostPopularCreator(self, creators: List[str], ids: List[str], views: List[int]) -> List[List[str]]:
        creator_views = defaultdict(int)
        creator_max_view = defaultdict(int)
        creator_best_id = defaultdict(str)

        for i in range(len(creators)):
            creator = creators[i]
            id = ids[i]
            view = views[i]

            creator_views[creator] += view

            if creator not in creator_max_view or view > creator_max_view[creator]:
                creator_max_view[creator] = view
                creator_best_id[creator] = id
            elif view == creator_max_view[creator] and id < creator_best_id[creator]:
                creator_best_id[creator] = id

        max_total_view = 0
        for creator in creator_views:
            max_total_view = max(max_total_view, creator_views[creator])

        result = []
        for creator in creator_views:
            if creator_views[creator] == max_total_view:
                result.append([creator, creator_best_id[creator]])

        return result