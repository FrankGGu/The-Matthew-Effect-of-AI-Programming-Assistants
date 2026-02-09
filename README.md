# The Matthew Effect of AI Programming Assistants: A Hidden Bias in Software Evolution (ICLR 2026)

[![Conference](https://img.shields.io/badge/ICLR-2026-brightgreen)](#)
[![Paper](https://img.shields.io/badge/OpenReview-Paper-blue)](https://openreview.net/forum?id=QjkJdcbSDe)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

</div>

> **AI programming assistants can amplify a “Matthew effect” in software ecosystems:** mainstream languages/frameworks get disproportionately better AI support, while niche ecosystems pay a sizable **AI productivity tax**.

This repository contains the code and released artifacts for the ICLR 2026 paper  
**“The Matthew Effect of AI Programming Assistants: A Hidden Bias in Software Evolution.”**  
It includes benchmark/task definitions, prompt templates, evaluation scripts, and analysis utilities for reproducing and extending our experiments.

---

## Citation

If you find this repository useful, please cite:

```bibtex
@inproceedings{ICLR-Gu-Liang-Ma-Li2026,
  title        = {The Matthew Effect of {AI} Programming Assistants: A Hidden Bias in Software Evolution},
  author       = {Fei Gu and Zi Liang and Jiahao Ma and Hongzong Li},
  booktitle    = {The Fourteenth International Conference on Learning Representations},
  year         = {2026},
  url          = {https://openreview.net/forum?id=QjkJdcbSDe}
}
```

---

## 🔥 TL;DR

- Under a controlled protocol, **popularity of a language/framework is a strong predictor** of LLM code-generation success—often more decisive than model “reasoning strength.”
- Representative result (best model): **Python Pass@1 = 79.81%** vs **Erlang Pass@1 = 24.31%** (3×+ gap).
- Failure modes differ: mainstream ecosystems more often fail as **Wrong Answer / Runtime Error** (runs but incorrect), while niche ecosystems frequently fail as **Compile Error** (toolchain/syntax instability).
- In realistic full-stack development under an iterative **Vibe Coding** protocol, mainstream stacks often converge in **1–3 rounds**, while niche/new stacks may require **5–10 rounds** or fail.

---

## 📌 Overview

LLM-powered programming tools (e.g., vibe coding, agentic coding) are reshaping how software is built.  
While prior work largely focuses on prompt engineering and short-horizon accuracy, we study **ecosystem-level consequences**:

> Do AI programming assistants reinforce existing popularity hierarchies, making dominant languages/frameworks even more dominant, and thereby reducing ecosystem diversity?

We answer this question with large-scale experiments across languages and full-stack frameworks.

---

## 🧪 Benchmark & Experiments


### 1) Algorithmic Tasks (Language Level)

- Source: public LeetCode problems
- Scale: **3,011** problems (Easy/Medium/Hard)
- Languages (**9**): Python, C++, C, Java, JavaScript, Go, Rust, Erlang, Racket
- Models: **5** commercial proprietary LLMs
- Total requests: **3,011 × 9 × 5 = 135,495** code generations
- Metric: LeetCode online judging, **Pass@1** (first submission success), plus error-type breakdown
  (Compile Error / Wrong Answer / Runtime Error / etc.)

<img width="513" height="288" alt="image" src="https://github.com/user-attachments/assets/680ebb0a-d9e0-45d1-944e-68e191e782a7" />

### 2) Framework Tasks (Stack Level)

We evaluate LLM performance in full-stack development via two layers of tasks:

1. **17** general CRUD-style tasks across **6** mainstream/emerging tech stacks  
2. **8** “divergent technology pathway” tasks (e.g., API Gateway, distributed KV, chat server),
   comparing **mainstream / mid / niche** stacks under the same requirements

**Protocol: VibeCoding**  
We only feed back raw error messages (no human rewriting), measuring the model’s ability to independently debug and converge, using:
- convergence rounds / completion rate
- failure categories (build/runtime/logic)

<img width="517" height="287" alt="image" src="https://github.com/user-attachments/assets/b21a2b0d-e9bd-46d5-984b-4a35e46794f7" />

---

## 📊 Key Findings

### Language Level: Productivity Gap

- Best-model example: **Python 79.81% vs Erlang 24.31% (Pass@1)**
- The harder the tasks, the larger the gap (from Easy → Hard)
- Niche languages show disproportionately high **Compile Error** rates, suggesting limited toolchain/syntax coverage

### Stack Level: “AI Productivity Tax”

- For the 17 CRUD tasks, mainstream stacks (e.g., Vue+Spring, React+Express, Django) typically succeed in fewer rounds
- For divergent-pathway tasks:
  - mainstream stacks often converge in **1–2 rounds**
  - niche/emerging stacks may need **5–10 rounds** or fail
- This can form a self-reinforcing loop:  
  **more adoption → more training data → better AI support → even more adoption**

<img width="302" height="287" alt="image" src="https://github.com/user-attachments/assets/c8118d29-9ae9-43ad-a42d-27e36b699461" />

---

