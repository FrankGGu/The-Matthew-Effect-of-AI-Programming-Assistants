from collections import defaultdict

class Solution:
    def mostPopularCreator(self, creators: list[str], video_ids: list[str], views: list[int]) -> list[list[str]]:
        creator_total_views = defaultdict(int)
        # Stores [max_views_for_this_creator, best_video_id_for_this_creator]
        # best_video_id_for_this_creator is chosen based on max views, then lexicographically smallest ID
        creator_best_video_info = {} 

        for i in range(len(creators)):
            creator = creators[i]
            video_id = video_ids[i]
            view_count = views[i]

            creator_total_views[creator] += view_count

            if creator not in creator_best_video_info:
                creator_best_video_info[creator] = [view_count, video_id]
            else:
                current_max_views, current_best_id = creator_best_video_info[creator]
                if view_count > current_max_views:
                    creator_best_video_info[creator] = [view_count, video_id]
                elif view_count == current_max_views:
                    if video_id < current_best_id:
                        creator_best_video_info[creator][1] = video_id

        max_total_views = 0
        if creator_total_views:
            max_total_views = max(creator_total_views.values())

        result = []
        for creator, total_views in creator_total_views.items():
            if total_views == max_total_views:
                result.append([creator, creator_best_video_info[creator][1]])

        return result