-module(luprefix).
-export([new/1, upload/2, longest/1]).

-record(luprefix_state, {
    max_video_id :: integer(),
    uploaded_videos :: gb_sets:set(),
    current_longest_prefix_candidate :: integer()
}).

new(N) ->
    #luprefix_state{
        max_video_id = N,
        uploaded_videos = gb_sets:new(),
        current_longest_prefix_candidate = 1
    }.

upload(VideoId, State = #luprefix_state{uploaded_videos = Uploaded, current_longest_prefix_candidate = CurrentCandidate}) ->
    NewUploaded = gb_sets:add(VideoId, Uploaded),
    NewCandidate = update_candidate(CurrentCandidate, NewUploaded, State#luprefix_state.max_video_id),
    State#luprefix_state{uploaded_videos = NewUploaded, current_longest_prefix_candidate = NewCandidate}.

longest(State = #luprefix_state{current_longest_prefix_candidate = CurrentCandidate}) ->
    CurrentCandidate - 1.

update_candidate(Candidate, UploadedSet, MaxId) ->
    case Candidate =< MaxId andalso gb_sets:is_member(Candidate, UploadedSet) of
        true ->
            update_candidate(Candidate + 1, UploadedSet, MaxId);
        false ->
            Candidate
    end.