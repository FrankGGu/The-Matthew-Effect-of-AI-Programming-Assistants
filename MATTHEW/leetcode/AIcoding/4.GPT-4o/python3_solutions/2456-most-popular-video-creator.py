from collections import defaultdict

class Solution:
    def mostPopularCreator(self, creators, ids, views):
        total_views = defaultdict(int)
        video_views = defaultdict(int)

        for creator, vid, view in zip(creators, ids, views):
            total_views[creator] += view
            if video_views[(creator, vid)] < view:
                video_views[(creator, vid)] = view

        max_views = max(total_views.values())
        result = []

        for creator in total_views:
            if total_views[creator] == max_views:
                max_video = max((video_views[(creator, vid)], vid) for vid in video_views if vid[0] == creator)
                result.append([creator, max_video[1]])

        return result