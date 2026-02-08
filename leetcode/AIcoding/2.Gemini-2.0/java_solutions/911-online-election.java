import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

class TopVotedCandidate {

    TreeMap<Integer, Integer> timeline;
    Map<Integer, Integer> votes;

    public TopVotedCandidate(int[] persons, int[] times) {
        timeline = new TreeMap<>();
        votes = new HashMap<>();
        int leader = -1;
        int maxVotes = 0;

        for (int i = 0; i < persons.length; i++) {
            int person = persons[i];
            int time = times[i];

            votes.put(person, votes.getOrDefault(person, 0) + 1);

            if (votes.get(person) >= maxVotes) {
                maxVotes = votes.get(person);
                leader = person;
            }

            timeline.put(time, leader);
        }
    }

    public int q(int t) {
        return timeline.floorEntry(t).getValue();
    }
}