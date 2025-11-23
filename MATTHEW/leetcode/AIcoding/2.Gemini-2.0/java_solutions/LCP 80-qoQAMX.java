import java.util.ArrayList;
import java.util.List;
import java.util.Random;

class Solution {

    private static final int POPULATION_SIZE = 100;
    private static final int GENE_LENGTH = 10;
    private static final double MUTATION_RATE = 0.01;
    private static final int GENERATIONS = 1000;

    private static final Random random = new Random();

    public int solve() {
        List<String> population = initializePopulation();

        for (int generation = 0; generation < GENERATIONS; generation++) {
            population = evolve(population);
        }

        String bestIndividual = findBestIndividual(population);
        return calculateFitness(bestIndividual);
    }

    private List<String> initializePopulation() {
        List<String> population = new ArrayList<>();
        for (int i = 0; i < POPULATION_SIZE; i++) {
            StringBuilder sb = new StringBuilder();
            for (int j = 0; j < GENE_LENGTH; j++) {
                sb.append(random.nextInt(2)); // Assuming genes are binary (0 or 1)
            }
            population.add(sb.toString());
        }
        return population;
    }

    private List<String> evolve(List<String> population) {
        List<String> newPopulation = new ArrayList<>();

        // Selection (Tournament Selection)
        for (int i = 0; i < POPULATION_SIZE; i++) {
            String parent1 = tournamentSelection(population);
            String parent2 = tournamentSelection(population);

            // Crossover (Single-Point Crossover)
            String child = crossover(parent1, parent2);

            // Mutation
            child = mutate(child);

            newPopulation.add(child);
        }

        return newPopulation;
    }

    private String tournamentSelection(List<String> population) {
        int tournamentSize = 5;
        String best = null;
        int bestFitness = -1;

        for (int i = 0; i < tournamentSize; i++) {
            String individual = population.get(random.nextInt(POPULATION_SIZE));
            int fitness = calculateFitness(individual);
            if (best == null || fitness > bestFitness) {
                best = individual;
                bestFitness = fitness;
            }
        }

        return best;
    }

    private String crossover(String parent1, String parent2) {
        int crossoverPoint = random.nextInt(GENE_LENGTH);
        return parent1.substring(0, crossoverPoint) + parent2.substring(crossoverPoint);
    }

    private String mutate(String individual) {
        StringBuilder sb = new StringBuilder(individual);
        for (int i = 0; i < GENE_LENGTH; i++) {
            if (random.nextDouble() < MUTATION_RATE) {
                sb.setCharAt(i, sb.charAt(i) == '0' ? '1' : '0');
            }
        }
        return sb.toString();
    }

    private int calculateFitness(String individual) {
        // Example fitness function: count the number of 1s
        int fitness = 0;
        for (char c : individual.toCharArray()) {
            if (c == '1') {
                fitness++;
            }
        }
        return fitness;
    }

    private String findBestIndividual(List<String> population) {
        String best = null;
        int bestFitness = -1;

        for (String individual : population) {
            int fitness = calculateFitness(individual);
            if (best == null || fitness > bestFitness) {
                best = individual;
                bestFitness = fitness;
            }
        }

        return best;
    }