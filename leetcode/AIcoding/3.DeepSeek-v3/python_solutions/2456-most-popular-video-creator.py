import collections

class Solution:
    def mostPopularCreator(self, creators: List[str], ids: List[str], views: List[int]) -> List[List[str]]:
        creator_total = collections.defaultdict(int)
        creator_videos = collections.defaultdict(list)

        for creator, vid_id, view in zip(creators, ids, views):
            creator_total[creator] += view
            creator_videos[creator].append((-view, vid_id))

        max_total = max(creator_total.values())
        popular_creators = [creator for creator, total in creator_total.items() if total == max_total]

        result = []
        for creator in popular_creators:
            videos = creator_videos[creator]
            videos.sort()
            result.append([creator, videos[0][1]])

        return result